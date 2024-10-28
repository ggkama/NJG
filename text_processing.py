import os
import fileinput
import glob

def update_first_character(file_path):
    with fileinput.FileInput(file_path, inplace=True) as file:
        for line in file:
            if file.isfirstline():
                print('4' + line[1:], end='')
            else:
                print(line, end='')

def update_first_character_in_folder(folder_path):
    # 폴더 내의 모든 텍스트 파일에 대해 작업
    for file_path in glob.glob(os.path.join(folder_path, '*.txt')):
        update_first_character(file_path)

# 작업할 폴더 경로를 지정
folder_path = './image_data/egg'

# 함수 호출로 업데이트 실행
update_first_character_in_folder(folder_path)
