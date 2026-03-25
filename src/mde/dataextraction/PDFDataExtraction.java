package mde.dataextraction;

public class PDFDataExtraction implements DataExtraction {
    private String datas;
    
    @Override
    public String extract(String input) {
        // PDF text extraction logic
        return "Extracted PDF data: " + input;
    }
    
    @Override
    public String extract(String filePath, String fileName) {
        // PDF file extraction logic
        return "Extracted from PDF file: " + filePath + "/" + fileName;
    }
}