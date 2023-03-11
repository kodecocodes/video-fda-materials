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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:todo/controllers/list_controller.dart';
import '../controllers/todo_controller.dart';

import 'card_column.dart';
import '../db/repository.dart';
import '../models/lists.dart';
import 'dialogs.dart';
import 'search_results.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final _searchQueryController = TextEditingController();
  String searchQuery = 'Search query';

  @override
  Widget build(BuildContext context) {
    final repository = ref.read(repositoryProvider);
    return StreamBuilder<List<TodoList>>(
        stream: repository.watchAllTodoLists(),
        builder: (context, AsyncSnapshot<List<TodoList>> snapshot) {
          var lists = <TodoList>[];
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            lists = snapshot.data ?? [];
          }
          final todoController = ref.read(todoControllerProvider);
          todoController.setLists(lists);
          return DefaultTabController(
            length: (lists.length + 1),
            child: Scaffold(body: createBody(context, repository, lists)),
          );
        });
  }

  Widget createTabBar(
      BuildContext context, Repository repository, List<TodoList> lists) {
    final listController = ref.read(listControllerProvider);
    final tabs = <Tab>[];
    for (final todoList in lists) {
      tabs.add(Tab(
        child: Text(
          todoList.name,
          style: const TextStyle(color: Colors.black),
        ),
      ));
    }
    tabs.add(Tab(
      child: SizedBox(
        height: 40,
        child: IconButton(
          color: Colors.blue,
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              addList(context, repository, listController);
            });
          },
        ),
      ),
    ));
    return Container(
      height: 50,
      alignment: Alignment.topLeft,
      child: TabBar(
        isScrollable: true,
        tabs: tabs,
      ),
    );
  }

  Widget createBody(
      BuildContext context, Repository repository, List<TodoList> lists) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        _buildSearchField(),
        createTabBar(context, repository, lists),
        Expanded(
          flex: 1,
          child: TabBarView(
            children: createTabViews(repository, lists),
          ),
        ),
      ],
    );
  }

  List<Widget> createTabViews(Repository repository, List<TodoList> lists) {
    final views = <Widget>[];
    for (final list in lists) {
      views.add(CardColumn(todoList: list));
    }
    views.add(Container());

    return views;
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 10,
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _startSearch,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: TextField(
                controller: _searchQueryController,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 16.0),
                onChanged: (query) => updateSearchQuery(query),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startSearch() {
    if (_searchQueryController.text.isNotEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return SearchResults(searchText: _searchQueryController.text);
      }));
    }
  }

  void updateSearchQuery(String newQuery) {
    searchQuery = newQuery;
  }
}
