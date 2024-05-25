# This Python file uses the following encoding: utf-8
import sys
import json

from pathlib import Path
from typing import Dict

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, QQmlContext
from PySide6.QtCore import Slot, QObject


class ReadSignal(QObject):
    """A class representing a signal handler for filtering contact data
    based on search input.
    """

    def __init__(self, context: QQmlContext, contact_list: Dict) -> None:
        """Initialize the ReadSignal instance.

        Args:
            context (QQmlContext): Qml context that contain the UI information.
            contact_list (Dict): JSON contact information.
        """
        super(ReadSignal, self).__init__()
        self.contact_list = contact_list
        self.context = context

    @Slot(str)
    def search_signal(self, output_search: str) -> None:
        """Receive the output of the search field
        and send the filtered data to the contact list.

        Args:
            output_search (str): output of the search field.
        """
        if output_search:
            filtered_data_list = list(
                filter(
                    lambda item:
                    self.is_contact(output_search, item),
                    self.contact_list
                )
            )
            context.setContextProperty("contactsModel", filtered_data_list)
        else:
            context.setContextProperty("contactsModel", self.contact_list)

    def is_contact(self, output_search: str, item: Dict) -> bool:
        """Filter function to search in either first name or last name.

        Args:
            output_search (str): output of the search field.
            item (Dict): dictionary containing contacts information.

        Returns:
            bool: return if the output_search is in the contact dictionary or not.
        """
        return (
            output_search.lower() in f"{item['firstname'].lower()} {item['lastname'].lower()}"
            or output_search.lower() in f"{item['lastname'].lower()} {item['firstname'].lower()}"
        )


if __name__ == "__main__":
    # read json, create a data dict and sort it by last name
    with open("./qml/models/contacts.json", 'r') as file:
        data_list = json.load(file)

    sorted_data_list = sorted(data_list, key=lambda data: data["lastname"])

    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()
    context = engine.rootContext()
    signal = ReadSignal(context, sorted_data_list)  # listen for signals

    context.setContextProperty("contactsModel", sorted_data_list)  # create contactsModel property
    context.setContextProperty("readSignal", signal)  # create ReadSignal property

    qml_file = Path(__file__).resolve().parent / "qml/main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
