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


#ifndef LISTMODELFILTEREDDATAENTRY_H
#define LISTMODELFILTEREDDATAENTRY_H

#include "listmodeltableviewbase.h"

class ListModelFilteredDataEntry : public ListModelTableViewBase
{
	Q_OBJECT
	Q_PROPERTY(QString filter	READ filter		WRITE setFilter		NOTIFY filterChanged	)
	Q_PROPERTY(QString colName	READ colName	WRITE setColName	NOTIFY colNameChanged	)

public:
	explicit ListModelFilteredDataEntry(BoundQMLTableView * parent, QString tableType);

	QVariant		data(	const QModelIndex &index, int role = Qt::DisplayRole)	const	override;
	Qt::ItemFlags	flags(	const QModelIndex &index)								const	override;
	void			rScriptDoneHandler(const QString & result)								override;
	QString			filter()														const				{ return _filter;	}
	QString			colName()														const				{ return _colName;	}
	OptionsTable *	createOption()															override;
	void			initValues(OptionsTable * bindHere)										override;
	int				getMaximumColumnWidthInCharacters(size_t columnIndex)			const	override;
	void			itemChanged(int column, int row, double value)							override;


public slots:
	void	sourceTermsChanged(Terms* termsAdded, Terms* termsRemoved)						override;
	void	modelChangedSlot()																override;
	void	setFilter(QString filter);
	void	dataSetChangedHandler();
	void	setColName(QString colName);


signals:
	void	filterChanged(QString filter);
	void	acceptedRowsChanged();
	void	colNameChanged(QString colName);

private:
	void	setAcceptedRows(std::vector<bool> newRows);
	void	setAcceptedRowsTrue()		{ setAcceptedRows(std::vector<bool>(getDataSetRowCount(), true)); }
	void	runFilter(QString filter);
	size_t	getDataSetRowCount();
	void	fillTable();

	QString						_filter,
								_colName;
	std::vector<bool>			_acceptedRows;
	std::vector<size_t>			_filteredRowToData;
	std::map<size_t, double>	_enteredValues;
	int							_editableColumn = 0;
	std::vector<std::string>	_dataColumns;
};

#endif // LISTMODELFILTEREDDATAENTRY_H