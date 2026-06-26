package cog1;

public class PdfFactory extends DocumentFactory {
	@Override
	public Document createDocument() {
		return new PdfDocument();
	}
}