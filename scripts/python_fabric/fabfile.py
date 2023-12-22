from fabric.api import *


def greeting(msg):
    print("Hello ", msg)


def system_info():
    print("disk space")
    local("df -h")

    print("memory")
    local("free -m")


def remote_exec():
    print("get system info")
    run("hostname")
    run("uptime")

    sudo("yum install mariadb-server -y")
    sudo("systemctl start mariadb")
    sudo("systemctl enable mariadb")


def web_setup(WEBURL, DIRNAME):
    print("START ###############################")
    local("apt install zip unzip -y")

    print("* dependency")
    sudo("yum install httpd wget unzip -y")

    sudo("systemctl start httpd")
    sudo("systemctl enable httpd")

    local(("wget -O website.zip %s") % WEBURL)
    local("unzip -o website.zip")

    with lcd(DIRNAME):
        local("zip -r tooplate.zip *")
        put("tooplate.zip", "/var/www/html/", use_sudo=True)

    with cd("/var/www/html/"):
        sudo("unzip -o tooplate.zip")

    sudo("systemctl restart httpd")

    print("END ###############################")
