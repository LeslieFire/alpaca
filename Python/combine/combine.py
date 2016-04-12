import os

def main():
	files = os.listdir(".")
	csvlist = [f  for f in files if f.endswith(".csv") and f != "result.csv"]

	OUTPUT = "result.csv"
	writer = open(OUTPUT, "wb")
	for csvfile in csvlist:
	    reader = open(csvfile, "rb")
	    next(reader)
	    for line in reader:
	        writer.write(line)
	    reader.close()
	writer.close()

if __name__ == "__main__":
	main()