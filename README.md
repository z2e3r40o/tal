# al

a few scripts I use to generate a distribution of only the html files in [theanarchistlibrary.org](https://theanarchistlibrary.org) at [QmYPadPn1pNEGK9GhjQ8SR8GY95SduxosmFpb23ys7ycq9](https://gateway.ipfs.io/ipfs/QmYPadPn1pNEGK9GhjQ8SR8GY95SduxosmFpb23ys7ycq9/)

the current site is generated by the following process:

1. download the torrent at http://theanarchistlibrary.org/special/the-torrent-2019-winter
2. run generate script: `$ ./generate.sh ~/Downloads/theanarchistlibrary.org/library`
3. upload: `$ ./upload.sh`
4. add resulting html dir to ipfs `$ ipfs add -r html`
