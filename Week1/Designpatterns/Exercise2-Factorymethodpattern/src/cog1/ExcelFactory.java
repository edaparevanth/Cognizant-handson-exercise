package cog1;

public class ExcelFactory extends DocumentFactory {
	@Override
	public Document createDocument() {
		return new ExcelDocument();
	}
}