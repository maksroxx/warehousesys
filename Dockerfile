FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

COPY pubspec.yaml ./

RUN flutter pub get

COPY . .

RUN rm -rf .dart_tool .packages

RUN flutter build web --release --no-tree-shake-icons

FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]