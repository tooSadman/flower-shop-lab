--Creating users tables
create table users (
  id serial not null,
  email varchar not null primary key,
  encrypted_password varchar not null,
  username varchar not null
);

--Creating flowers table
create table flowers (
  id serial not null,
  flower_name varchar not null primary key,
  picture varchar not null,
  price int not null
);

--Creating orders table
create table orders (
  id serial not null,
  flower_name varchar references flowers(flower_name),
  customer varchar references users(email),
  price int not null
);

--Inserting values into table users
insert into users 
  (id, email, encrypted_password, username)
values
  (1, 'john@gmail.com', 'john', 'john'),
  (2, 'stashkiv@gmail.com', 'stashkiv', 'stashkiv'),
  (3, 'fufelok@dasdasd', 'yurii', 'yurii'),
  (4, 'mykola@gmail.com', 'mykola', 'mykola');
 

--Inserting values into table flowers
insert into flowers 
  (id, flower_name, picture, price)
values 
  (1, 'Rose', 'https://www.springintheair.com/wp-content/uploads/bfi_thumb/red-roses-50-set-compressor-n5oucgj8yzgm0fcs1j2el4wxysgxatrjyhwsk99vtk.jpg', 20),
  (2, 'Tulip', 'https://www.whiteflowerfarm.com/mas_assets/cache/image/6/3/6/0/25440.Jpg', 15),
  (3, 'Iris', 'https://www.gardenia.net/storage/app/public/guides/detail/83847060_mOptimized.jpg', 18),
  (4, 'Peony', 'https://florium.ua/media/catalog/product/cache/2/file/9df78eab33525d08d6e5fb8d27136e95/p/a/paeonia_patio_peony_madrid_03510_1_1.jpg', 17),
  (5, 'Crocus', 'https://s3.amazonaws.com/cdn0.brecks.com/images/500/63942.jpg', 25),
  (6, 'Lily', 'https://s3.amazonaws.com/cdn0.brecks.com/images/500/73689A.jpg', 30),
  (7, 'Daisy', 'https://images-na.ssl-images-amazon.com/images/I/61jtIbIPbgL._AC_SL1005_.jpg', 16),
  (8, 'Poppy', 'https://cdn.shopify.com/s/files/1/1186/5156/products/Red-Poppy_1024x1024.jpeg?v=1456914865', 19);
