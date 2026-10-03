# tcslog-sample

Sample code using [tcslog](https://github.com/vomlehn/tcslog): writes a chain of
segment files filled with small ASCII messages.

The segment size is deliberately tiny (`SEGMENT_FILE_HEADER_LEN + 36` bytes), so
the log rolls over after a handful of records and the resulting chain is
interesting to inspect with `tcslog-dump`.

## Setup

`tcslog`'s build script requires `TIMER_RESOLUTION`, the system timer resolution
in nanoseconds. It has no default. Copy the example config and adjust it for your
machine:

```sh
cp .cargo/config.toml.example .cargo/config.toml
```

`.cargo/config.toml` is gitignored so each machine can pick its own value. You
can also pass the value on the command line instead:
`TIMER_RESOLUTION=1 cargo build`.

## Usage

```sh
cargo run -- <dir> <prefix> <suffix> [--verbose]
```

For example:

```sh
cargo run -- /tmp/sample-logs sample- .tcslog --verbose
```

This creates `/tmp/sample-logs` if needed and writes a root segment file plus its
successors, named `<prefix><session-id><suffix>`.

To try it without leaving anything behind, `run-sample.sh` writes the chain into a
temporary directory, lists what was written, and deletes the directory afterwards:

```sh
./run-sample.sh --verbose
```

## Library

The binary is a thin wrapper around `create_sample_logs`, which the crate also
exposes as a library:

```rust
use tcslog_sample::create_sample_logs;

let result = create_sample_logs("/tmp/sample-logs", "sample-", ".tcslog", false)?;
println!("{} messages, root {}", result.message_count, result.root_file);
```

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  <http://www.apache.org/licenses/LICENSE-2.0>)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or <http://opensource.org/licenses/MIT>)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.
