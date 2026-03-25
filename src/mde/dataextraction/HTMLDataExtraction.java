package mde.dataextraction;

public class HTMLDataExtraction implements DataExtraction {
    private String datas;
    
    @Override
    public String extract(String input) {
        // HTML text extraction logic
        return "Extracted HTML data: " + input;
    }
    
    @Override
    public String extract(String filePath, String fileName) {
        // HTML file extraction logic
        return "Extracted from HTML file: " + filePath + "/" + fileName;
    }
}