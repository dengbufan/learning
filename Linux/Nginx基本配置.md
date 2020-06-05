                                            linux centos教程（千叶）
    
                      --------------------------------------------------------------------------------
一、虚拟机环境下centos7 minimal的基本配置

1.联网
  改配置
    vi /etc/sysconfig/network-scripts/ifcfg-xxx
      =>ONBOOT=yes
    wq! 

  重启网络
    service xxx start|stop|restart
    或
    /etc/init.d/network restart

   centos7（不同于7.0之前的版本ipconfig）查看IP地址：ip addr

  关闭centos命令模式的警告声音
    


    想把警告声去掉把/etc/inputrc 中的set bell-style 的值（取值范围是:none, visible, audible）改为 visible，并将注释去掉
    
    再reboot 或 shutdown -r now重启系统就OK啦


2.更新系统、软件
  yum update -y
  yum upgrade


3.更新源
  备份原来的源
  mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

  安装 wget(单线程下载工具，快)
      yum install wget -y
    
  163源下载
  wget http://mirrors.163.com/.help/CentOS7-Base-163.repo
  mv CentOS7-Base-163.repo /etc/yum.repos.d/

  然后重建缓存：
  yum clean all
  yum makecache


  备注:
    阿里yum源:http://mirrors.aliyun.com/repo/
     163(网易)yum源: http://mirrors.163.com/.help/
    中科大的Linux安装镜像源：http://centos.ustc.edu.cn/
    搜狐的Linux安装镜像源：http://mirrors.sohu.com/
    北京首都在线科技：http://mirrors.yun-idc.com/

4.putty登录
  输入ip、保存

5.安装vim
  yum install vim -y

  命令模式
    :q   离开
    :wq  保存离开
    :wq! 则为强制储存后离开
    :q!  强制离开不储存档案

  插入模式

--------------------------------------------------------------------------------

node
  1.添加源
  https://nodejs.org/en/download/package-manager/

  2.装
  yum install nodejs -y

nginx
  1.添加源
  http://nginx.org/en/linux_packages.html#stable

  2.重载配置
  /usr/sbin/nginx -s reload

  3.端口转发

  4.反向代理



二、各类软件安装配置
  补充：
    查看软件安装在了那些地方
          whereis name
    Linux系统下yum命令查看安装了哪些软件包：

          $yum list installed //列出所有已安装的软件包 
    
    列出所有可安装的软件包 命令：yum list 
    
    列出所有可更新的软件包 命令：yum list updates
    
    查看是否安装了某个软件：
    
        rpm包安装的，可以用rpm -qa看到，如果要查找某软件包是否安装，用 rpm -qa | grep "软件或者包的名字"。


        deb包安装的，可以用dpkg -l能看到。如果是查找指定软件包，用dpkg -l | grep "软件或者包的名字"；
    
        yum方法安装的，可以用yum list installed查找，如果是查找指定包，命令后加 | grep "软件名或者包名"；
    
             例如：yum list installed openssl |grep openssl
??openssl.x86_64? 1:1.0.2k-8.el7? @anaconda

?
                   如果没有返回值则表示没有安装

1、mysql的安装配置（从最新版本的linux系统开始，默认的是 Mariadb而不是mysql！）
      
    先检查系统是否装有mysql：  rpm -qa | grep mysql
    
    这里执行安装命令是无效的，因为centos-7默认是Mariadb，所以执行以下命令只是更新Mariadb数据库
           yum install mysql
    
    删除可用：yum remove mysql
    
    下载mysql的repo源：wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
    
    安装mysql-community-release-el7-5.noarch.rpm包：sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
    
    安装这个包后，会获得两个mysql的yum repo源：/etc/yum.repos.d/mysql-community.repo， /etc/yum.repos.d/mysql-community-source.repo
    
    安装mysql：sudo yum install mysql-server  ，安装完成后，没有密码，需要重置密码，安装后再次查看mysql
    
        如果报错，内容含有：
             Error: Package: mysql-community-libs-5.6.35-2.el7.x86_64 (mysql56-community)
             Requires: libc.so.6(GLIBC_2.17)(64bit)
             Error: Package: mysql-community-server-5.6.35-2.el7.x86_64 (mysql56-community)
             Requires: libc.so.6(GLIBC_2.17)(64bit)
             Error: Package: mysql-community-server-5.6.35-2.el7.x86_64 (mysql56-community)
             Requires: systemd
             Error: Package: mysql-community-server-5.6.35-2.el7.x86_64 (mysql56-community)
             Requires: libstdc++.so.6(GLIBCXX_3.4.15)(64bit)
             Error: Package: mysql-community-client-5.6.35-2.el7.x86_64 (mysql56-community)
             Requires: libc.so.6(GLIBC_2.17)(64bit)
             You could try using --skip-broken to work around the problem
             You could try running: rpm -Va --nofiles --nodigest
    
        解决办法：
             #yum install glibc.i686
             # yum list libstdc++*
    
    重置密码，重置密码前，首先要登录
    
             mysql -u root
        
        登录时有可能报这样的错：ERROR 2002 (HY000): Can’t connect to local MySQL server through socket ‘/var/lib/mysql/mysql.sock’ (2)，
        原因是/var/lib/mysql的访问权限问题。下面的命令把/var/lib/mysql的拥有者改为当前用户：
    
             sudo chown -R openscanner:openscanner /var/lib/mysql
        如果报chown: 无效的用户: "openscanner:openscanner"错误，更换命令，并用 ll 查看目录权限列表
    
            chown root /var/lib/mysql/
            ll
    
    然后，重启服务：service mysqld restart
    
    接下来登录重置密码：
    
       mysql -u root -p
            mysql > use mysql;
            mysql > update user set password=password('123456') where user='root';
            mysql > exit;
    重启mysql服务后生效
       
    必要时加入以下命令行，为root添加远程连接的能力。链接密码为 “root”（不包括双引号）
    
            mysql> GRANT ALL PRIVILEGES ON *.* TO root@"%" IDENTIFIED BY "root";
    
    查询数据库编码格式，确保是 UTF-8
    
            show variables like "%char%";
    
        需要修改编码格式为UTF-8，导入数据库sql的时候，请确保sql文件为utf8编码 
    
        进入mysql命令行后 输入
                 set names utf8;
    
       （测试数据库数据） 
        再进入数据库 use test; 
        在导入sql脚本 source test.sql;

   开放3306端口号，远程访问 （mysql的默认访问端口）

         a:   firewalld 防火墙（centos-7）运行命令,
    
              firewall-cmd --zone=public --add-port=3306/tcp --permanent
    
              firewall-cmd --reload
    
              关闭防火墙：
    
              systemctl stop firewalld
              开启防火墙：
    
          systemctl start firewalld
              
         b:   iptables 防火墙（centos6.5及其以前）运行命令：
    
                  vim /etc/sysconfig/iptables
    
             在文件内添加下面命令行
    
                 -A INPUT -p tcp -m state --state NEW -m tcp --dport 3306 -j ACCEPT
    
             然后重启:service iptables restart

   数据库配置文件修改,我们需要修改数据库配置文件，这个要看我们数据库的配置的，有些是在/etc/my.cnf，有些是/etc/my.conf:

            我们需要在[client]部分添加脚本：
            socket=/var/lib/mysql/mysql.sock  ( mysql.sock 文件位置 )
            host=localhost
            user=数据库用户
            password='数据库密码'

   采用命令导出和导入数据库

            导出数据库:mysqldump --defaults-extra-file=/etc/my.cnf database > database.sql
    
            导入数据库:mysql --defaults-extra-file=/etc/my.cnf database < database.sql
    
            这里我们可以看到上面的命令和以前常用的快速导入和导入命令有所不同了，需要加载我们配置的MYSQL配置文件，
    
            这个“/etc/my.cnf”要根据我们实际的路径修改。用这样的命令导出备份和导入是没有错误提示的。
   启动mysql：
            systemctl start mysqld（centos7.x）
   关闭mysql：
            service mysqld stop(centos6.5--)

            systemctl stop mysqld（centos7.x）

   终止MySQL进程：
            killall  mysqld

三、各类编程语言环境配置

    1.c/c++开发环境：
    
           c环境：yum install gcc


​                   
           c++环境：yum install gcc-c++
    
    2.java JDK

四、web服务器配置
    
    1.Nginx
         (1)首先先安装epel-release源
    
                yum install epel-release
    
         (2)安装Nginx(笔记可能会过时如果出错可以参考官网：http://nginx.org/)
                yum install nginx
    
         (3)运行nginx,nginx不会自动运行需要我们自行启动
                systemctl start nginx
    
         (4)如果正在运行防火墙请允许http和https通信
    
                firewall-cmd --permanent --zone=public --add-service=http 
                firewall-cmd --permanent --zone=public --add-service=https
                firewall-cmd --reload
    
         (5)几个常用的nginx命令
    
                   nginx -t 检查nginx语法是否错误
                   service nginx restart 重启nginx
        （6）卸载Nginx：
      		
    	yum remove nginx
    
                删除Nginx相关文件：
    
    	whereis nginx
    	
    	rm -rf /usr/local/nginx	 （rm -rf谨慎使用，删库跑路的梗）


​	 
​                 






















