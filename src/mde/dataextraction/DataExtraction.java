package mde.dataextraction;

public interface DataExtraction {
    String datas = "";
    
    String extract(String input);
    String extract(String filePath, String fileName);
}