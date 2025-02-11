class MessageAPI:
    def __init__(self):
        # 初始化三个消息列表，分别用于存储不同类型的消息
        self.messages = {1: [], 2: [], 3: []}

    def getMsg(self, msg_type, msg_content, sender_address, receiver_address):
        """
        接收消息并根据类型存储
        msg_type: 消息类型，1 用户请求消息，2 用户 attr，3 金融机构返回消息
        msg_content: 消息内容
        sender_address: 发送者地址
        receiver_address: 接收者地址
        """
        if msg_type not in self.messages:
            print("Invalid message type!")
            return

        msg = {
            "content": msg_content,
            "sender": sender_address,
            "receiver": receiver_address
        }

        # 将消息存储到对应的类型列表中
        self.messages[msg_type].append(msg)
        print(f"Message added: {msg_type}, {msg_content}")

    def queryMessages(self, address, msg_type=None):
        """
        查询某个地址的所有消息，消息类型可选
        address: 查询的地址，可以是发送者地址或接收者地址
        msg_type: 可选，消息类型（1、2、3），默认查询所有类型
        返回匹配的消息列表，查询失败则返回空
        """
        result = []

        # 查询对应类型的消息
        for m_type in self.messages:
            if msg_type is None or m_type == msg_type:
                # 对应类型检索
                for msg in self.messages[m_type]:
                    if msg["sender"] == address or msg["receiver"] == address:
                        result.append(msg)

        return result

    def getMessagesByType(self, msg_type):
        """
        获取某种类型的所有消息
        msg_type: 消息类型（1、2、3）
        返回某种类型的消息列表
        """
        if msg_type not in self.messages:
            print("Invalid message type!")
            return []

        return self.messages[msg_type]


# 示例用法：
api = MessageAPI()

# 添加一些消息
api.getMsg(1, "Request for loan", "0x402b8cA508F1eD76d74Bab0a8cEA21fae9702536",
           "0x56a1b8cA508F1eD76d74Bab0a8cEA21fae9702537")
api.getMsg(2, "Attribute update", "0x402b8cA508F1eD76d74Bab0a8cEA21fae9702536",
           "0x56a1b8cA508F1eD76d74Bab0a8cEA21fae9702537")
api.getMsg(3, "Financial institution update", "0x56a1b8cA508F1eD76d74Bab0a8cEA21fae9702537",
           "0x402b8cA508F1eD76d74Bab0a8cEA21fae9702536")

# 查询某个地址的所有消息
messages = api.queryMessages("0x402b8cA508F1eD76d74Bab0a8cEA21fae9702536")
print(messages)

# 查询某个地址和特定类型的消息
messages_type_1 = api.queryMessages("0x402b8cA508F1eD76d74Bab0a8cEA21fae9702536", 1)
print(messages_type_1)

# 获取所有某种类型的消息
messages_type_2 = api.getMessagesByType(2)
print(messages_type_2)
