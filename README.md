
<p align="center">
  <img width="460" height="300" src="<picture_url>">
</p>

<h1 align="center"><a href="<blog_url>"><blog_name>
</a></h1>


`openssl rand -base64 741 > mongo-replica-set.key
chmod 600 mongodb.key`


mongodb://root:root@localhost:27017,localhost:27027,localhost:27037?authSource=admin&replicaSet=tutorial-cluster


rs.slaveOk()



mongo -u root -p root --authenticationDatabase admin
mongo -port 27027 -u root -p root --authenticationDatabase admin
mongo -port 27037 -u root -p root --authenticationDatabase admin
