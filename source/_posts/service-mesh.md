---
layout: service_mesh
title: Service Mesh
date: 2020-09-25 14:51:02
tags: 
  - cloud native
---

Service Mesh 是服务间通信的基础设施。 Buoyant 公司 CEO William Morgan 在博文《What's a service mesh? And why do I need one?》中解释了什么是 Service Mesh，以及为什么云原生需要 Service Mesh。

> A service mesh is a dedicated infrastructure layer for handling service-to-service communication. It's responsible for the reliable delivery for requests through the complex topology of services that comprise a modern, cloud native application. In practice, the service mesh is typically implemented as an array of lightweight network proxies that are deployed alongside application code, without the application needing to be aware.

## Service Mesh 由来

自计算机网络诞生至今，我们经历了以下几个阶段：

1. 主机之间直接使用网线相连

   {% asset_img 1.png %}

2. 网络层出现，解耦了网络与应用程序

   {% asset_img 2.png %}

3. 在应用程序内部集成控制流

  {% asset_img 3.png %}

4. 将流控从应用程序分离并加入到网络层（TCP/IP）

  {% asset_img 4.png %}

5. 微服务出现，各个微服务中集成服务发现和断路器

  {% asset_img 5.png %}

6. 出现了专门用于服务发现和断路器的软件包/库（SDK），如 Twitter 的 Finagle 和 Facebook 的 Proxygen。这时候还是需要集成到应用程序内部。

   {% asset_img 5-a.png %}

7. 出现了专门用于服务发现和断路器的开源软件，如 Netflix OSS、Airbnb 的 synapse 和 nerve。

   {% asset_img 6.png %}

8. 最后作为微服务的中间层 Service Mesh 出现了。

   

## 理解 Service Mesh

Service Mesh 可以比作是应用程序或者说微服务间的 TCP/IP，负责服务之间的网络调用、限流、熔断和监控。对于编写应用程序来说一般无须关心 TCP/IP 这一层（比如通过 HTTP 协议的 RESTful 应用），同样使用 Service Mesh 也就无须关心服务之间的那些原来是通过应用程序或者其他框架实现的事情，比如 Spring Cloud、OSS，现在只要交给 Service Mesh 就可以了。

Service Mesh 的架构如下图所示：

{% asset_img serivce-mesh-arch.png %}

图片来自：[Pattern: Service Mesh](https://philcalcado.com/2017/08/03/pattern_service_mesh.html)

Service Mesh 作为 sidecar 运行，对应用程序来说是透明的，所有应用程序间的流量都会通过它，所以对应用程序流量的控制都可以在 Service Mesh 中实现。

## 参考

[What's a service mesh? And why do I need one?](https://buoyant.io/2017/04/25/whats-a-service-mesh-and-why-do-i-need-one/)

[Service Mesh 服务网格](https://jimmysong.io/kubernetes-handbook/usecases/service-mesh.html)

[Pattern: Service Mesh](https://philcalcado.com/2017/08/03/pattern_service_mesh.html)

