/*
 * Copyright (c) 2023 Kodeco LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * This project and source code may use libraries or frameworks that are
 * released under various Open-Source licenses. Use of those libraries and
 * frameworks are governed by their own individual licenses.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/db/repository.dart';
import 'package:todo/models/models.dart';

class SearchResults extends ConsumerWidget {
  final String searchText;

  const SearchResults({super.key, required this.searchText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.read(repositoryProvider);
    return FutureBuilder(
        future: repository.findTodos(searchText),
        builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final todos = snapshot.data ?? [];
          return Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text(
                    'Search Results for $searchText',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                    flex: 1,
                    child: ListView.separated(
                        separatorBuilder: (context, int index) =>
                            const Divider(),
                        itemCount: todos.length,
                        itemBuilder: (BuildContext context, int index) {
                          final todo = todos[index];
                          return ListTile(
                            title: Text(todo.name,
                              style: const TextStyle(
                                  fontSize: 14),
                            ),
                            trailing: Text(todo.notes ?? '',
                              style: const TextStyle(
                                  fontSize: 12),
                            ),
                          );
                        })),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        });
  }
}
