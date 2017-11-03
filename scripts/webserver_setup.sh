# install apache
sudo yum update -y
sudo yum install httpd -y

# create web page
echo '<html><h1>Testing Config!</h1></html>' | sudo tee -a /var/www/html/index.html

# start apache
sudo service httpd start
sudo chkconfig httpd on