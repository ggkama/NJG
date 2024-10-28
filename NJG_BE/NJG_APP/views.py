import subprocess
import datetime
import pymysql
from django.shortcuts import redirect
import tempfile
import pandas as pd

def check_view(request):
    # DB 사용을 위한 연결 (도커용)
    mydb = pymysql.connect(
        host="172.17.0.3",
        user="django",
        password="1234",
        database="recipe"
    )

    cursor = mydb.cursor()

    sql = "SELECT image_path FROM input_image ORDER BY id DESC LIMIT 1"

    cursor.execute(sql)
    
    results = cursor.fetchall()

    image_data = results[0][0]  # 여기에 데이터베이스에서 읽어온 이미지 데이터를 넣어주세요
    temp_file = tempfile.NamedTemporaryFile(delete=False, suffix=".png")
    temp_file.write(image_data)
    temp_file.close()

    # Object Detection 부분 시작
    command = [
        "python", "./detect.py",
        "--weights", "./best.pt",
        "--img", "416",
        "--conf", "0.2",
        "--source", temp_file.name
    ]

    objects_detected = []

    result = subprocess.run(command, stderr=subprocess.PIPE, text=True)
    print("result", result)
    lines = result.stderr.split('\n')
    for line in lines:
        if line.startswith('image'):
            detected_objects_str = line.split(':')[-1].strip()
            objects_detected.append(detected_objects_str)

    # print(objects_detected)
    # # Object Detection 부분 끝


    # 유사도 판별 시작
    from sklearn.metrics.pairwise import cosine_similarity
    import re
    # print(objects_detected[0])
    selected_words = re.sub(r'(\d )', '', re.sub(r'(\d+\.\d+)ms', '', re.sub(r'(\d+)x(\d+)', '', objects_detected[0]))).strip().split(',')[:-1]
    print("SELECTED WORDS : ", selected_words)
    for i in range(len(selected_words)):
        selected_words[i] = selected_words[i].strip()
    map_dict = {}

    f = open('./mapping.txt', 'r', encoding='utf-8')
    lines = f.readlines()
    for i in lines:
        temp = i.split('-')
        for num in range(len(selected_words)):
            if selected_words[num] in temp[0]:
                map_dict[temp[0]] = temp[1].strip()
                selected_words[num] = 'NONE'
                
    selected_words = list(map_dict.values())
    print("SELECTED WORDS AFTER : ", selected_words)
    select_string = ""
    for string in selected_words:
        select_string += string + ","

    df = pd.read_csv('./similarity.csv')

    index_list = list(df['Unnamed: 0'])
    df.drop('Unnamed: 0', axis=1, inplace=True)
    # 이전에 생성한 compare_df 코드 (이어지는 부분에 삽입)
    compare_df = pd.DataFrame(columns=df.columns)
    compare_df.loc["Inserted Picture"] = [word in selected_words for word in compare_df.columns]

    final_df = pd.concat([df, compare_df])

    # Cosine Similarity 계산
    cosine_similarities = cosine_similarity(final_df)

    # DataFrame의 index를 가져와서 출력에 활용
    index_names = final_df.index.tolist()
    
    # 특정 Document만 출력 (예: Document 4)
    document_number = -1  # 0부터 시작하므로 Document 4는 3번 인덱스
    document_name = index_names[document_number]

    similarity_list = []

    # print(f"Cosine Similarities for {document_name}:")
    for i, similarity in enumerate(cosine_similarities[document_number]):
        other_document_name = index_names[i]
        if other_document_name != document_name:

            similarity_list.append([index_list[i], similarity])

    similarity_list.sort(key=lambda x:x[1], reverse=True)
    print(similarity_list[:10])
    # 유사도 판별 끝

    sim_result = ""
    # DB에 추천하는 레시피 ID 넣기 시작
    for element in similarity_list[:10]:
        try:
            select_query = "SELECT id FROM new_table WHERE title='" + element[0] + "'"
            cursor.execute(select_query)  

            results = cursor.fetchall()
            print("results : ", results)
            sim_result += str(results[0][0]) + " "
        except:
            print("ERROR")
    print("check similarity", similarity_list)
    select_query = "INSERT INTO similarity_list (similar_number, predict_names, createdAt) VALUES (%s, %s, %s)"
    val = (sim_result.strip(), select_string, datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))

    cursor.execute(select_query, val)
    mydb.commit()

    cursor.close()
    mydb.close()

    return redirect("http://localhost:8090/list")
    # DB에 추천하는 레시피 ID 넣기 끝

from django.http import HttpResponse

def testview(request):
    mydb = pymysql.connect(
        host="172.17.0.3",
        user="django",
        password="1234",
        database="recipe"
    )

    cursor = mydb.cursor()

    sql = "SELECT image_path FROM input_image ORDER BY id DESC LIMIT 1"

    cursor.execute(sql)
    
    results = cursor.fetchall()

    image_data = results[0][0]  # 여기에 데이터베이스에서 읽어온 이미지 데이터를 넣어주세요
    temp_file = tempfile.NamedTemporaryFile(delete=False, suffix=".png")
    temp_file.write(image_data)
    temp_file.close()

    # Object Detection 부분 시작
    command = [
        # "python", "C:/Users/Playdata/Desktop/Playdata_Final_Project/yolov5/yolov5/detect.py",
        "python", "detect.py",
        "--weights", "best.pt",
        "--img", "416",
        "--conf", "0.2",
        "--source", temp_file.name
    ]

    objects_detected = ["ASDF", "QWER", "ZXCV"]

    result = subprocess.run(command, stderr=subprocess.PIPE, text=True)
    print("result", result)
    lines = result.stderr.split('\n')
    for line in lines:
        if line.startswith('image'):
            detected_objects_str = line.split(':')[-1].strip()
            objects_detected.append(detected_objects_str)

    print(objects_detected)

    return HttpResponse([objects_detected, result, lines])

def check_view2(request):
    # DB 사용을 위한 연결 (로컬용)
    mydb = pymysql.connect(
        host="localhost",
        user="root",
        password="1234",
        database="recipe"
    )

    cursor = mydb.cursor()

    sql = "SELECT image_path FROM input_image ORDER BY id DESC LIMIT 1"

    cursor.execute(sql)
    
    results = cursor.fetchall()

    image_data = results[0][0]  # 여기에 데이터베이스에서 읽어온 이미지 데이터를 넣어주세요
    temp_file = tempfile.NamedTemporaryFile(delete=False, suffix=".png")
    temp_file.write(image_data)
    temp_file.close()

    # Object Detection 부분 시작
    command = [
        "python", "./detect.py",
        "--weights", "./best.pt",
        "--img", "416",
        "--conf", "0.2",
        "--source", temp_file.name
    ]

    objects_detected = []

    result = subprocess.run(command, stderr=subprocess.PIPE, text=True)
    print("result", result)
    lines = result.stderr.split('\n')
    for line in lines:
        if line.startswith('image'):
            detected_objects_str = line.split(':')[-1].strip()
            objects_detected.append(detected_objects_str)

    # print(objects_detected)
    # # Object Detection 부분 끝


    # 유사도 판별 시작
    from sklearn.metrics.pairwise import cosine_similarity
    import re
    # print(objects_detected[0])
    selected_words = re.sub(r'(\d )', '', re.sub(r'(\d+\.\d+)ms', '', re.sub(r'(\d+)x(\d+)', '', objects_detected[0]))).strip().split(',')[:-1]
    print("SELECTED WORDS : ", selected_words)
    for i in range(len(selected_words)):
        selected_words[i] = selected_words[i].strip()
    map_dict = {}

    f = open('./mapping.txt', 'r', encoding='utf-8')
    lines = f.readlines()
    for i in lines:
        temp = i.split('-')
        for num in range(len(selected_words)):
            if selected_words[num] in temp[0]:
                map_dict[temp[0]] = temp[1].strip()
                selected_words[num] = 'NONE'
                
    selected_words = list(map_dict.values())
    print("SELECTED WORDS AFTER : ", selected_words)
    select_string = ""
    for string in selected_words:
        select_string += string + ","

    df = pd.read_csv('./similarity.csv')

    index_list = list(df['Unnamed: 0'])
    df.drop('Unnamed: 0', axis=1, inplace=True)
    # 이전에 생성한 compare_df 코드 (이어지는 부분에 삽입)
    compare_df = pd.DataFrame(columns=df.columns)
    compare_df.loc["Inserted Picture"] = [word in selected_words for word in compare_df.columns]

    final_df = pd.concat([df, compare_df])

    # Cosine Similarity 계산
    cosine_similarities = cosine_similarity(final_df)

    # DataFrame의 index를 가져와서 출력에 활용
    index_names = final_df.index.tolist()
    
    # 특정 Document만 출력 (예: Document 4)
    document_number = -1  # 0부터 시작하므로 Document 4는 3번 인덱스
    document_name = index_names[document_number]

    similarity_list = []

    # print(f"Cosine Similarities for {document_name}:")
    for i, similarity in enumerate(cosine_similarities[document_number]):
        other_document_name = index_names[i]
        if other_document_name != document_name:

            similarity_list.append([index_list[i], similarity])

    similarity_list.sort(key=lambda x:x[1], reverse=True)
    print(similarity_list[:10])
    # 유사도 판별 끝

    sim_result = ""
    # DB에 추천하는 레시피 ID 넣기 시작
    for element in similarity_list[:10]:
        try:
            select_query = "SELECT id FROM new_table WHERE title='" + element[0] + "'"
            cursor.execute(select_query)  

            results = cursor.fetchall()
            print("results : ", results)
            sim_result += str(results[0][0]) + " "
        except:
            print("ERROR")

    print("check similarity", similarity_list)
    select_query = "INSERT INTO similarity_list (similar_number, predict_names, createdAt) VALUES (%s, %s, %s)"
    val = (sim_result.strip(), select_string, datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))

    cursor.execute(select_query, val)
    mydb.commit()

    cursor.close()
    mydb.close()
    # 나의 아이피 넣기
    return redirect("http://192.168.0.149:8089/list")
    # DB에 추천하는 레시피 ID 넣기 끝