app [main!] { 
    cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br" 
}

import cli.Stdout
import cli.File
import cli.Utc

main! = |_args|
    start = Utc.now!({})
    readfile!({})?
    finish = Utc.now!({})
    duration = Num.to_str(Utc.delta_as_millis(start, finish))
    Stdout.line!("Completed in ${duration} ms")


readfile! = |{}|
    reader = File.open_reader!("/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv")?
    read_summary = process_line!(reader, { lines_read: 0, bytes_read: 0 })?
    Stdout.line!("Done reading file: ${Inspect.to_str(read_summary)}")


# https://github.com/roc-lang/basic-cli/blob/main/examples/file-read-buffered.roc

ReadSummary : {
    lines_read : U64,
    bytes_read : U64,
}

## Count the number of lines and the number of bytes read.
process_line! : File.Reader, ReadSummary => Result ReadSummary _
process_line! = |reader, { lines_read, bytes_read }|
    when File.read_line!(reader) is
        Ok(bytes) if List.len(bytes) == 0 ->
            Ok({ lines_read, bytes_read })

        Ok(bytes) ->
            process_line!(
                reader,
                {
                    lines_read: lines_read + 1,
                    bytes_read: bytes_read + (List.len(bytes) |> Num.int_cast),
                },
            )

        Err(err) ->
            Err(ErrorReadingLine(Inspect.to_str(err)))