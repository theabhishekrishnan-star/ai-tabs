package mde.dataextraction;

public class DataExtractionFactory {
    
    public static DataExtraction getExtractor(String fileType) {
        switch (fileType.toLowerCase()) {
            case "pdf":
                return new PDFDataExtraction();
            case "excel":
            case "xls":
            case "xlsx":
                return new ExcelDataExtraction();
            case "html":
            case "htm":
                return new HTMLDataExtraction();
            default:
                throw new IllegalArgumentException("Unsupported file type: " + fileType);
        }
    }
}