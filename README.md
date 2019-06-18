# webhook配置记录

## 工具准备

* [ ] github  
* [ ] gitlab
* [x] coding

#### 选择`coding`的原因： 
- `github`私有仓库收费，不适合企业
- `gitlab`本地部署数据安全，但占用服务器空间大，有利有弊

## webhook部署工具

下载：[https://github.com/padipata/webhook-configuration.git](https://github.com/padipata/webhook-configuration.git)

#### 文件说明

- hook：Linux编译文件，直接运行即可
- hook.go：源码，需要修改请查看 [常见问题](#常见问题)

#### 支持

- [x] 支持Linux平台下部署
- [x] 支持Git协议，即: git@coding.net:user/project.git
- [ ] 不支持Http协议（注意！），即: https://git.coding.net/user/project.git
- [x] 支持自定义Shell脚本

#### 命令列表

```shell
./hook             # 启动服务器，-p 缺省，默认 `7442`
./hook -p 7442     # 启动监听端口为7442的服务器

./hook -s reload   # 重启
./hook -s stop     # 强行停止 SIGKILL
```

#### 多项目部署

> 如有多个项目，增加多个 `.json` 文件配置即可，__不需要重启hook进程__

- 项目命名规范（强制）

    - **user.project.branch.json**

**例如你的coding用户名为`edision`，项目名称为`web-clock`，部署分支为`dev`，则文件命名为： `edision.web-clock.dev.json`**

#### JSON配置说明

```json
{
    "path": "项目在本机的目录，如 /home/wwwroot/abc",
    "head": "项目的别名，如origin",
    "password": "hook的验证密码"
}
```

* * *

## 常见问题

- go build 在mac下打包在Linux下是不兼容的，需要用以下命令打包
`env GOOS=linux GOARCH=amd64 go build -o hook hook.go`

- 如果需要自己修改源码，可能会出现有些go包下载不下来
    1. 到 [https://github.com/golang/](https://github.com/golang/) 下面下载对应的包
    2. 放到`GOPATH`（不知道的看下面）
        例如：`org.golang.x.sys.unix`，则需要在`/User/Mr.peng/go/src`下新建`/golang/org/x`

- 如何查看自己的`GOPATH`？
可以在安装完`go`环境后，使用`go env`命令

## coding 配置

- 配置ssh：`ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`
- 复制`/etc/ssh/id_rsa.pub`内容到`coding`-> 个人设置 -> SSH公钥
- 首次拉代码必须使用`git`协议（只需要git clone即可，服务器已配置好账号）
