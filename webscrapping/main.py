import requests as r
import json
from bs4 import BeautifulSoup as BS

resp = r.get('https://digitalinnovation.one/')
resp.encoding = 'utf-8'  # Pra fazer a decodificação e trazes os acentos
soup = BS(resp.text, 'html.parser')  # Faz a trasndormação de obj em txt para obj html


# Pega o conteudo, dado uma classe em html, e retorna seu conteudo em uma lista
cursos = soup.find_all(class_="col-xs-3 col-md-3 col-lg-3 col-xl-3")

todos_cursos = list()

for curso in cursos:  # Varrendo o elemento capturado
    p = list()

    titulo = curso.h3.text  # Atacando a tag buscando as heads em formato texto

    prev = curso.find_all('p')  # Pegando todos os previews em curso e guardando numa lista
    for item in prev:  # Varrendo a lista pegando cada elemento de curso em html e convertendo para texto
        p.append(item.text)

    img = curso.img['src']

    # Armazenando em estrutura de dicionário
    todos_cursos.append({
        'title': titulo,
        'couses': p[:],
        'thumb_course': img
    })
    p.clear()
with open('cursos.json', 'w') as json_file:  # Está atribuindo o nome json_file para o arquivo aberto
    json.dump(todos_cursos, json_file, indent=3, ensure_ascii=False)
    # Esse comando acima converte em json o documento aberto colocando nossa lista dentro, indentando e tratando ascii
