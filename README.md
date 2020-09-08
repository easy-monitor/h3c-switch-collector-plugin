## 工作原理

1. h3c-switch-collector-plugin 监控插件包使用了第三方的 SNMP Exporter 进行指标采集，GitHub 链接为 https://github.com/prometheus/snmp_exporter 。

## 准备工作

1. 确认要采集的 H3C 交换机启用了 SNMP，包括其具体的管理 IP、团体字。

## 使用方法

### 导入监控插件包

1. 下载该项目的压缩包（https://github.com/easy-monitor/h3c-switch-collector-plugin/archive/master.zip ）。

2. 建议解压到 EasyOps 平台服务器上的 `/usr/local/easyops/monitor_plugin_packages` 该目录下。

3. 使用 EasyOps 平台内置的监控插件包导入工具进行导入，具体命令如下，请替换其中的 `8888` 为当前 EasyOps 平台具体的 `org`。

```sh
$ cd /usr/local/easyops/collector_plugin_service/tools
$ sh plugin_op.sh install 8888 /usr/local/easyops/monitor_plugin_packages/h3c-switch-collector-plugin
```

4. 导入成功后访问 EasyOps 平台的「采集插件」小产品页面 (http://your-easyops-server/next/collector-plugin )，就能看到导入的 "h3c-switch-collector-plugin" 采集插件。

### 启动 SNMP Exporter

1. 编辑 conf/snmp.yml 配置文件，配置具体的团体字。

```
if_mibs:
  ...
  auth:
    community: public
```

2. 启动 SNMP Exporter，具体命令如下。

```sh
$ cd /usr/local/easyops/monitor_plugin_packages/h3c-switch-collector-plugin/script
$ sh deploy/start_script.sh
```

3. 通过访问 http://127.0.0.1:9116/snmp?target=1.2.3.4 来获取指标数据，请替换其中的 `127.0.0.1:9116` 为 Exporter 具体的监听地址和端口，target 参数为 H3C 交换机具体的管理 IP。

```sh
$ curl http://127.0.0.1:9116/snmp?target=1.2.3.4 
```

4. 接下来可使用导入的采集插件为具体的资源实例创建采集任务。

## 启动参数

| 名称 | 类型 | 默认值 | 说明 |
| ---- | ---- | ---- | ---- |
| exporter-host | string | 127.0.0.1 | Exporter 监听地址 |
| exporter-port | int | 9116 | Exporter 监听端口 |
