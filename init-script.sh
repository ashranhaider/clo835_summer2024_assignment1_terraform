git clone https://github.com/ashranhaider/clo835_summer2024_assignment1.git
cd clo835_summer2024_assignment1

docker build -t my_db -f Dockerfile_mysql . 
docker build -t my_app -f Dockerfile . 



docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=pw -e MYSQL_DATABASE=employees -p 3306:3306 my_db

docker run -d --name python-app-container -p 8080:8080 \
  -e DBHOST=172.17.0.2 \
  -e DBPORT=3306 \
  -e DBUSER=root \
  -e DATABASE=employees \
  -e DBPWD=pw \
  -e APP_COLOR=blue \
  my_app


docker run -d --name python-app-container2 -p 8081:8080 \
  -e DBHOST=172.17.0.2 \
  -e DBPORT=3306 \
  -e DBUSER=root \
  -e DATABASE=employees \
  -e DBPWD=pw \
  -e APP_COLOR=blue \
  my_app


docker run -d --name python-app-container3 -p 8082:8080 \
  -e DBHOST=172.17.0.2 \
  -e DBPORT=3306 \
  -e DBUSER=root \
  -e DATABASE=employees \
  -e DBPWD=pw \
  -e APP_COLOR=pink \
  my_app

docker run -d --name python-app-container4 -p 8083:8080 \
  -e DBHOST=172.17.0.2 \
  -e DBPORT=3306 \
  -e DBUSER=root \
  -e DATABASE=employees \
  -e DBPWD=pw \
  -e APP_COLOR=lime \
  my_app

