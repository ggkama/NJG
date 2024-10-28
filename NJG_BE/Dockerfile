# 베이스 이미지 설정
FROM python:3.9

# 작업 디렉토리 설정
WORKDIR /app

# 현재 디렉토리의 모든 파일을 /app에 복사
COPY . /app

# 필요한 패키지 설치
# RUN apt-get install -y libmysqlclient-dev=5.7.31-0ubuntu0.18.04.1
RUN apt-get update
RUN apt-get install -y libgl1-mesa-glx
RUN apt-get install -y libglib2.0-0
RUN pip install mysqlclient
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Django 서버 실행
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
