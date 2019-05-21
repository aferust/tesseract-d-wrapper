## D wrapper to the tesseract for basic functionality 

This is not a complete d binding to the Tesseract-OCR. You can just simply add `source/tesseractd.d`to your project,
and link tesseract library files in the dub.json of your test application. I could not test it on any OS other than Ubuntu.
Actually, I had linking problems with the tesseract on windows, and I was too lazy to figure it out.
An example usage with opencvd can be found [here](https://github.com/aferust/opencvd/blob/master/examples/ocr_with_tesseract_simple.d).
