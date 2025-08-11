import os
import sys
import subprocess

source = os.path.join(os.path.dirname(sys.argv[0]), 'Samples')
TinyEXIF = os.path.join(source, '../build/TinyEXIFdemo')
exiftool = 'exiftool'
ext = 'exif.txt'
if len(sys.argv) > 1:
	ext = sys.argv[1]
for root, dirs, filenames in os.walk(source):
	for f in filenames:
		if f[-4:].lower() == '.jpg':
			fullpath = os.path.join(source, f)
			imgexif = fullpath[:-3] + ext
			print('parse ' + fullpath + ' to ' + imgexif)
			# 运行TinyEXIFdemo并将输出写入文件
			result = subprocess.run([TinyEXIF, fullpath], capture_output=True, text=True)
			with open(imgexif, 'w') as outfile:
				outfile.write(result.stdout)
			# 运行exiftool并将输出写入文件
			result = subprocess.run([exiftool, '-n', '-s', '-G', fullpath], capture_output=True, text=True)
			with open(imgexif + '.txt', 'w') as outfile:
				outfile.write(result.stdout)