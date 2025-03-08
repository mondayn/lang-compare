
import concurrent.futures
import time

def track_duration(fn):
    def wrapper(*args,**kwargs):
        start = time.perf_counter()
        fn(*args,**kwargs)
        end = time.perf_counter()
        print(f"{fn.__name__}: {end - start:.4f} seconds")
        return
    return wrapper

# file_path='/home/nathan/Downloads/Chase1122_Activity20231118.CSV'
file_path='/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv'

@track_duration
def single_thread():
    i=0
    with open(file_path, "r",encoding="utf-8",errors='ignore') as file:
        for line in file:
            s = line.strip().split(',')
            i+=1

    print(i)

@track_duration
def multi_thread():

    def read_chunk(filename, start, size):
        """Reads a specific chunk of a file."""
        with open(filename, "r", encoding="utf-8",errors='ignore') as f:
            f.seek(start)
            return f.read(size)

    chunk_size = 1024 * 1024  # 1MB per chunk
    file_size = None

    #get file size
    with open(file_path, "r", encoding="utf-8",errors='ignore') as f:
        f.seek(0, 2)  # Move to end of file
        file_size = f.tell()

    # Create tasks for reading chunks
    chunks = [(file_path, start, min(chunk_size, file_size - start)) for start in range(0, file_size, chunk_size)]

    # Process chunks in parallel
    with concurrent.futures.ThreadPoolExecutor() as executor:
        results = list(executor.map(lambda args: read_chunk(*args), chunks))

    full_content = "".join(results)
    # print(full_content[:500])  # Print first 500 characters

if __name__=='__main__':
    single_thread()
    multi_thread()

    # pass
