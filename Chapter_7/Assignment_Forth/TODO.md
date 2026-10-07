# Forth Project TODO

## Done
- [x] Read words from `STDIN`
- [x] Detect/push numbers to the Forth Data Stack (`RSP`)
- [x] Static dictionary node structure
- [x] Linked-list head with `last_word`
- [x] XT points to the native implementation

## In Progress
- [ ] Implement basic native words: `+ - * / dup drop swap .`

## TODO
- [ ] `cfa` — receive a word header address and return the address of its XT
- [ ] Connect `find_word -> cfa -> XT`
- [ ] Implement `next` / execution flow
- [ ] Build the interpreter loop
- [ ] Add Forth Return Stack
- [ ] Implement `docol` and `exit`
- [ ] Add colon words

## cfa
`cfa` skips:

`previous pointer -> name\0 -> flags`

and returns the address of the word's **XT**.

```text
word header -> cfa -> XT -> implementation
```
