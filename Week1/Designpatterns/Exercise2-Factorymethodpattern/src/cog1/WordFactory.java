package cog1;

public class WordFactory extends DocumentFactory {
	@Override
	public Document createDocument() {
		return new WordDoument();
	}
}