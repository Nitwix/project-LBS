// Learn By Sorting: Flutter app to help people learn by sorting.
// Copyright (C) 2020  Niels Lachat
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//
// The license file can be found in the LICENSE file, at the root of the repo.
//
// The author can be contacted by email at nielsnfsmw@gmail.com.

import 'dart:math' show Random;

extension RandomElement<T> on List<T> {
  T get randomElement{
    return this[Random().nextInt(this.length)];
  }
}