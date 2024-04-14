import subprocess

def executar_comando():
    # Comando que você deseja executar no ambiente debian
    comando_a_executar = "ngrok tcp 8022"

    # Abrindo um subprocesso para executar o comando no ambiente debian
    processo = subprocess.Popen(["proot-distro", "login", "debian"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    # Enviando o comando para o stdin do processo para ser executado dentro do ambiente debian
    stdout, stderr = processo.communicate(input=(comando_a_executar + "\n").encode())

    # Exibindo a saída
    if stdout:
        print("Saída do comando:", stdout.decode())

    # Exibindo o erro, se houver
    if stderr:
        print("Erro durante a execução do comando:", stderr.decode())

# Iniciar
executar_comando()
