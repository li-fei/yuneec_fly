import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:fly/yuneec/utils/SPutils.dart';

class ClientSocket {
  var gl_sock;             // 拿到socket实例，存储到provide中，便于其他页面使用socket的方法
  var response;            // 接收socket返回回来的数据
  var gl_context;          // 存储传入进来的context，provide的方法在调用时需要传
  var token;               // 获取本地token
  bool netWorkStatus = true;     // 网络状态
  bool socketStatus = false;     // socket状态

  // 初始化socket连接
  void Connect(context) async {

    // 获取本地存储Token
    token = await SPutils.getString('token');

    // 判断token是否为空并且网络状态是否为没有网络：停止心跳发送
    if(token.isEmpty || !netWorkStatus){
      return;
    }

    //创建一个Socket连接到指定地址与端口
    await Socket.connect('11.111.111.11', 9500).then((socket){
      print('---------连接成功------------');
      socketStatus = true;
      gl_sock = socket;
      gl_context = context;
      // 存储全局socket对象
      // Provide.value<SocketProvider>(context).setSocket(gl_sock);
      // 全局的socket设置为在线状态,该方法由项目决定酌情添加
      // Provide.value<SocketProvider>(context).setOnlineSocket(true);
      // 向服务器发送token验证
      Map arguments = {
        "type":"verify_token",
        "token":token[0]
      };
      gl_sock.write(json.encode(arguments));
      // socket监听
      gl_sock.listen(dataHandler,
          // onError: errorHandler,
          onDone: doneHandler,
          cancelOnError: false);
      // gl_sock.close();
    }).catchError((e) {
      print("socket无法连接: $e");
    });
  }

  // 接收socket返回报文
  dataHandler(data) async {
    print('-------Socket发送来的消息-------');
    var cnData = await utf8.decode(data);
    response = json.decode(cnData.toString());
    print(response);
  }

  // Socket出现断开的问题
  void doneHandler(){
    socketStatus = false;
    reconnectSocket();          //调用重连socket方法
  }

  // 重新连接socket
  void reconnectSocket(){
    int count = 0;
    const period = const Duration(seconds: 1);
    // 定时器
    Timer.periodic(period, (timer) {
      // 每一次重连之前，都删除关掉上一个socket
      // gl_sock.close();
      gl_sock = null;
      count++;
      if(count >= 3){
        print('时间到了!!!开始从连socket');
        // 链接socket
        Connect(gl_context);      // 重连
        count = 0;                // 倒计时设置为0
        timer.cancel();           // 关闭倒计时
        timer = null;             // 清空倒计时
      }
    });
  }

  var address = new InternetAddress('192.168.1.22');
  int port = 1024;
  // connect(address, port);

  void connect(InternetAddress clientAddress, int port) {
    Future.wait([RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)]).then(
            (values) {
          RawDatagramSocket _socket = values[0];
          _socket.listen((RawSocketEvent e) {
            print(e);
            switch (e) {
              case RawSocketEvent.read:
                Datagram dg = _socket.receive();
                if (dg != null) {
                  dg.data.forEach((x) => print(x));
                }
                _socket.writeEventsEnabled = true;
                break;
              case RawSocketEvent.write:
                _socket.send(new Utf8Codec().encode('Hello from client'), clientAddress, port);
                break;
              case RawSocketEvent.closed:
                print('Client disconnected.');
            }
          });
        });
  }

}
