# Utiliza una imagen base de Node.js
FROM node:latest AS build 

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos de la aplicación al contenedor
COPY package.json ./

# Instala las dependencias
RUN npm install

COPY . .

# Construye la aplicación
RUN npm run build

# Configura Nginx como servidor web
FROM nginx:latest AS prod-stage

# Copia los archivos de la aplicación construida a la ubicación predeterminada de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expone el puerto 80 para permitir el acceso al servidor web
EXPOSE 80

# Inicia el servidor Nginx al ejecutar el contenedor
CMD ["nginx", "-g", "daemon off;"]
