#Use an existing docker image as a base
From node:alpine as builder

#Chnage the workdir, create it if not exist
WORKDIR '/app'

#Copy the files needed for npm install
COPY package.json .

#Download and install a dependency
Run npm config set registry http://registry.npmjs.org/  
Run npm install

#Copy all the files to the container
COPY . .

#This will create build directory
Run npm run build

#Copy from builder phase
From nginx
COPY --from=builder /app/build /usr/share/nginx/html
