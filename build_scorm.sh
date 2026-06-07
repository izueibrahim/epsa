#!/bin/bash
# Script untuk membungkus prototaip EPSA SCORM 1.2
# Membungkus index.html + imsmanifest.xml + folder public/ (imej, video, pustaka tempatan)
# ke dalam satu fail .ZIP yang lengkap, mematuhi piawaian SCORM 1.2 dan boleh dijalankan
# tanpa sambungan internet.
set -e

OUT=epsa_scorm_pack.zip

echo "================================================="
echo "Membungkus Pakej SCORM 1.2 Teknologi Makanan..."
echo "================================================="

# Buang fail ZIP lama jika ada
rm -f "$OUT"

# Bersihkan fail .DS_Store dalam folder public sebelum membungkus
find public -name '.DS_Store' -delete 2>/dev/null || true

# Bungkus fail di akar (root) ZIP — imsmanifest.xml mesti berada di paras teratas.
# Kecualikan sampah macOS (.DS_Store, __MACOSX). Folder .git, skrip ini dan ZIP lama
# tidak disenaraikan, jadi ia tidak dimasukkan.
zip -r -X "$OUT" index.html imsmanifest.xml public \
    -x "*.DS_Store" -x "__MACOSX/*"

echo "-------------------------------------------------"
if [ $? -eq 0 ]; then
    SIZE=$(du -h "$OUT" | cut -f1)
    echo "BERJAYA! Fail pakej dibina di:"
    echo "  $OUT  (saiz: $SIZE)"
    echo "-------------------------------------------------"
    echo "Saiz mesti tidak melebihi 20MB (keperluan tender 2.11)."
    echo "Sila muat naik fail ini ke LMS kerajaan atau SCORM Cloud untuk penilaian."
else
    echo "RALAT: Gagal membungkus fail!"
    echo "-------------------------------------------------"
fi
