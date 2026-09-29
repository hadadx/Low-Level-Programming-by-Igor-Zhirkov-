___
**Question 45 Decipher this segment selector: 0x08**
Index = 1 
TI = 0 
RPL = 0


**Question 46 read about microcode in general and processor pipelines.**

**Question 47 read about different replacement strategies. What other strategies exist?**
- **FIFO (First In, First Out)** – removes the page that has been in memory the longest.
- **LFU (Least Frequently Used)** – removes the page that was used the fewest times.
- **MFU (Most Frequently Used)** – removes the page that was used the most times, assuming it may no longer be needed.
- **Clock / Second-Chance** – similar to FIFO, but pages that were recently used get a second chance before removal.
- **NRU (Not Recently Used)** – prefers removing pages that have not been accessed recently, especially if they were not modified.
- **Aging** – keeps a small history of page usage and removes pages that have been inactive for a long time.
- **Optimal / MIN** – removes the page that will not be used for the longest time in the future. It is theoretically best, but impossible to implement perfectly because the future is unknown.
