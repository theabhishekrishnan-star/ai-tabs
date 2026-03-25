package mde.dataextraction;

public class ExcelDataExtraction implements DataExtraction {
    private String datas;
    
    @Override
    public String extract(String input) {
        // Excel text extraction logic
        return "Extracted Excel data: " + input;
    }
    
    @Override
    public String extract(String filePath, String fileName) {
        // Excel file extraction logic
        return "Extracted from Excel file: " + filePath + "/" + fileName;
    }
}