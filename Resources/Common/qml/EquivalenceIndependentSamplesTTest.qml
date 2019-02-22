//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

import QtQuick 2.8
import QtQuick.Layouts 1.3
import JASP.Controls 1.0
import JASP.Theme 1.0

Form
{
    usesJaspResults: true
    plotHeight: 300
    plotWidth:  350

    VariablesForm
    {
        height: 200
        AssignedVariablesList { name: "variables";			title: qsTr("Variables");			allowedColumns: ["scale"]	}
        AssignedVariablesList { name: "groupingVariable";	title: qsTr("Grouping Variable");	allowedColumns: ["ordinal", "nominal"]; singleItem: true }
    }

    GridLayout
    {
            GroupBox
            {
                title: qsTr("Tests")
                CheckBox { name: "students";                        text: qsTr("Student");                          checked: true	}
                CheckBox { name: "welchs";                          text: qsTr("Welch")                                             }
            }

            GroupBox
            {
                title: qsTr("Additional Statistics")
                CheckBox { name: "descriptives";					text: qsTr("Descriptive Statistics")	}
                CheckBox { name: "plots";                           text: qsTr("Plots")	}
            }

            GroupBox
            {
                DoubleField { name: "lowerbound";	text: qsTr("Lower equivalende bound");		defaultValue: -0.05}
                DoubleField { name: "upperbound";	text: qsTr("Upper equivalence bound");      defaultValue: 0.05}
                DropDown
                {
                    name: "boundstype"
                    indexDefaultValue: 1
                    text: qsTr("Type of Bounds")
                    model: ListModel
                    {
                        ListElement { title: "cohensd"; value: "Cohen's d"}
                        ListElement { title: "raw";     value: "Raw"}
                    }
                }
                DoubleField { name: "alpha";        text: qsTr("Alpha level");                  defaultValue: 0.05}
            }

    }
}
