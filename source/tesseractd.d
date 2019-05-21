module tesseractd;

import std.stdio;
import std.string;
import std.conv;

alias TessOcrEngineMode = int;
enum: TessOcrEngineMode {
    OEM_TESSERACT_ONLY,
    OEM_LSTM_ONLY,
    OEM_TESSERACT_LSTM_COMBINED,
    OEM_DEFAULT
}

alias TessPageSegMode = int;
enum: TessPageSegMode {
    PSM_OSD_ONLY,
    PSM_AUTO_OSD,
    PSM_AUTO_ONLY,
    PSM_AUTO,
    PSM_SINGLE_COLUMN,
    PSM_SINGLE_BLOCK_VERT_TEXT,
    PSM_SINGLE_BLOCK,
    PSM_SINGLE_LINE,
    PSM_SINGLE_WORD,
    PSM_CIRCLE_WORD,
    PSM_SINGLE_CHAR,
    PSM_SPARSE_TEXT,
    PSM_SPARSE_TEXT_OSD,
    PSM_COUNT
}

extern (C){
    TessBaseAPI TessBaseAPICreate();
    
    void TessBaseAPIDelete(TessBaseAPI handle);
    
    int TessBaseAPIInit1(TessBaseAPI handle,
                                        const char* datapath,
                                        const char* language,
                                        TessOcrEngineMode oem, char** configs,
                                        int configs_size);
    
    int TessBaseAPIInit2(TessBaseAPI handle,
                                            const char* datapath,
                                            const char* language,
                                            TessOcrEngineMode oem);
    
    int TessBaseAPIInit3(TessBaseAPI handle,
                                            const char* datapath,
                                            const char* language);
    
    int TessBaseAPIInit4(
        TessBaseAPI handle, const char* datapath, const char* language,
        TessOcrEngineMode mode, char** configs, int configs_size, char** vars_vec,
        char** vars_values, size_t vars_vec_size, bool set_only_non_debug_params);
    
    void TessBaseAPISetPageSegMode(TessBaseAPI handle, TessPageSegMode mode);
    
    void TessBaseAPISetImage(TessBaseAPI handle,
                                            ubyte* imagedata,
                                            int width, int height,
                                            int bytes_per_pixel,
                                            int bytes_per_line);
    
    char* TessBaseAPIGetUTF8Text(TessBaseAPI handle);
}

struct TessBaseAPI{
    void* p;
    
    static TessBaseAPI opCall(){
        return TessBaseAPICreate();
    }
    
    int Init(string datapath, string language, TessOcrEngineMode oem){
        return TessBaseAPIInit2(this, datapath.toStringz, language.toStringz, oem);
    }

    void SetPageSegMode(TessPageSegMode mode){
        TessBaseAPISetPageSegMode(this, mode);
    }
    
    void SetImage(ubyte* imagedata, int width, int height, int bytes_per_pixel, int bytes_per_line){
        TessBaseAPISetImage(this, imagedata, width, height, bytes_per_pixel, bytes_per_line);
    }

    string GetUTF8Text(){
        char* cstr = TessBaseAPIGetUTF8Text(this);
        return cstr.to!string;
    }
}


void Destroy(TessBaseAPI handle){
    TessBaseAPIDelete(handle);
}
