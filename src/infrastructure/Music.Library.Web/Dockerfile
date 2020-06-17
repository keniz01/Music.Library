FROM node:10

# Create a work directory and copy over our dependency manifest files.
WORKDIR /app
COPY /ClientApp/src /app/src
COPY /ClientApp/public /app/public
COPY /ClientApp/package*.json ./
COPY /ClientApp/tsconfig.json ./

# If you're using yarn:
#  yarn build
RUN npm install

COPY . .

# Expose PORT 3000 on our virtual machine so we can run our server
EXPOSE 3000

# Run 'npm start' when the container starts.
CMD ["npm", "start"]