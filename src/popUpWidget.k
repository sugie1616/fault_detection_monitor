using konoha.qt4.*;

class PopUpWidget{

	QWidget popUpWidget;
	QTextEdit textWidget;
	QVBoxLayout popUpLayout;

	void myPopUpShow(String fileName);

	PopUpWidget(){
	}

	void myPopUpShow(String fileName){

		popUpWidget = new QWidget();
		popUpWidget.setWindowTitleOL("Source Code Of Task :");
		popUpLayout = new QVBoxLayout();
		textWidget = new QTextEdit();
		taskLog = new QLabel();

		InputStream in = new InputStream(fileName);
		String sourceCode;
		while ((sourceCode = in.readLine()) != null){
			if (sourceCode != null){
				textWidget.append(sourceCode);
			}
		}
		popUpLayout.addWidget(textWidget);
		popUpWidget.setLayout(popUpLayout);
		popUpWidget.show();
	}
}
