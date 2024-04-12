# 使用node的基础镜像
FROM node:18

# 在容器内部创建一个目录作为工作空间
WORKDIR /usr/src

# 将宿主机的依赖复制到容器中，目的是后面的npm install能在构建容器时安装好
COPY . /usr/src 
RUN npm install && mv ./node_modules /tmp && rm -rf * && mv /tmp/node_modules .

# 当容器启动时执行编译脚本
CMD cp -r /src/* /usr/src/ && npm run build&&cp -r /usr/src/dist /src/
#CMD ["bash"]

# sudo docker build -t nodebuilder .
# sudo docker run -v.:/src nodebuilder
# sudo cp -r ./dist /var/www/html/