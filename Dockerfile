# build phase, le ponemos un tag y lo llamamos builder
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json . 
RUN npm install 
COPY . . 
RUN npm run build

# second phase -> run phase
FROM nginx 
# primero vamos a copiar el build de la fase anterior e indicar donde queremos que se copie, esa es la carpeta de nginx donde debe estar segun docker hub
COPY --from=builder /app/build /usr/share/nginx/html

# solo tomamos el resultado del build, el final de la imagen no va a tener nada de alpine ni npm installs, porque
# eso solo se precisa para el build, dsp para funcionar en producccion no se necesita mas 
