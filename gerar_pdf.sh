#!/bin/bash

# Nome do arquivo PDF gerado
OUTPUT_FILE="resultado_final.pdf"

# 1. Verifica dependências (ImageMagick)
if ! command -v magick &> /dev/null && ! command -v convert &> /dev/null; then
    echo "Erro: ImageMagick não encontrado."
    echo "Para instalar no Ubuntu/Debian: sudo apt install imagemagick"
    echo "Para instalar no macOS: brew install imagemagick"
    exit 1
fi

# Define qual binário usar (magick para v7+, convert para legado)
CMD="convert"
if command -v magick &> /dev/null; then
    CMD="magick"
fi

# 2. Configura o Bash para lidar com case-insensitive e arquivos ausentes
shopt -s nullglob nocaseglob
ARQUIVOS=(*.jpg *.jpeg *.png)

# 3. Verifica se existem imagens no diretório
if [ ${#ARQUIVOS[@]} -eq 0 ]; then
    echo "Aviso: Nenhuma imagem JPG ou PNG encontrada no diretório atual."
    exit 1
fi

echo "Iniciando a conversão de ${#ARQUIVOS[@]} imagens..."

# 4. Executa a junção e conversão para PDF
$CMD "${ARQUIVOS[@]}" "$OUTPUT_FILE"

# 5. Valida o resultado
if [ $? -eq 0 ]; then
    echo "Sucesso! PDF gerado em: $OUTPUT_FILE"
else
    echo "Erro: Falha ao tentar gerar o PDF."
    exit 1
fi
