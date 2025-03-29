
#python3 readfile.py

import concurrent.futures
import time
import psutil
import os

import psycopg2
from itertools import islice
DB_ARGS={'dbname':'util','user':'test','password':'pw','host':'localhost','port':5432}


def memory_usage():
    process = psutil.Process(os.getpid())
    return process.memory_info().rss / 1024 / 1024  # Return memory usage in MB

def track_duration(fn):
    def wrapper(*args,**kwargs):
        # start_mem = memory_usage()
        start = time.perf_counter()
        fn(*args,**kwargs)
        end = time.perf_counter()
        # end_mem = memory_usage()
        print(f"{fn.__name__}: {end - start:.4f} seconds")
        # print(f'starting memory {start_mem}')
        # print(f'ending memory {end_mem}')
        # print(f'memory difference {end_mem-start_mem}')
        return
    return wrapper

#https://www.census.gov/data/datasets/2023/dec/rdo/2019-2023-CVAP.html
file_path=(
# '/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv'
    'sample2.csv'
)

@track_duration
def single_thread():
    i=0
    with open(file_path, "r",encoding="utf-8",errors='ignore') as file:
        for line in file:
            #s = line.strip().split(',')  #makes a big difference
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

def truncate():
    with psycopg2.connect(**DB_ARGS) as conn:
        cursor = conn.cursor()
        cursor.execute('truncate table tract;')
        conn.commit()
        cursor.close()

def get_first_two(line):
    items = line.split(',')
    return (items[0],items[1])

@track_duration
def insert():
    '''batch insert executemany'''
    BATCH_SIZE=1000000
    try:
        with psycopg2.connect(**DB_ARGS) as conn:
            cursor = conn.cursor()
            i = 0
            # with open(file_path, "r",encoding="utf-8",errors='ignore') as file:
            with open(file_path, "r",encoding="utf-8",errors='ignore') as file:
                while True:
                    batch = list(islice(file, BATCH_SIZE))  
                    if not batch:
                        break

                    data_to_insert = list(map(lambda r: get_first_two(r), batch ))
                    cursor.executemany("INSERT INTO tract (name, county) VALUES (%s, %s)", data_to_insert)
                    conn.commit()
                    print('inserted batch ',i)
                    i+=1
                    if i > 3:
                        break
            cursor.execute('select count(*) as records from tract;')
            result = cursor.fetchone()
            print('records=',result)
            cursor.close()
    except Exception as e:
        print("Error:", e)

@track_duration
def copy_from():
    try:
        with psycopg2.connect(**DB_ARGS) as conn:
            cursor = conn.cursor()

            with open(file_path, "r") as file:
                next(file) 
                cursor.copy_from(file, "tract", sep=",", columns=("name", "county"))

            conn.commit()
            print("CSV data loaded successfully!")
            cursor.close()

    except Exception as e:
        print("Error:", e)


if __name__=='__main__':

    # import pandas as pd
    # print(pd.read_csv(file_path,encoding="utf-8",encoding_errors='ignore')[['geoname','lntitle']].head(2)
    # # .to_csv(NEWFILE,index=False
    # )

    # limit = 10000000
    # pd.DataFrame({'name':range(limit),'county':'test'}).to_csv('/home/nathan/lang-compare/sample.csv',index=False)
                    
    # single_thread()
    # multi_thread()
    # truncate()
    # insert()
    # copy_from()

    pass
