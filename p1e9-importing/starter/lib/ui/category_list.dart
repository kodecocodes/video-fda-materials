/*
 * Copyright (c) 2021 Razeware LLC
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
import 'package:get/get.dart';
import '../controllers/list_controller.dart';
import '../db/repository.dart';
import '../models/lists.dart';
import '../models/category.dart';
import 'dialogs.dart';

class CategoryList extends StatelessWidget {
  final TodoList todoList;

  const CategoryList({Key? key, required this.todoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Get.find<Repository>();
    return GetBuilder<ListController>(
      tag: todoList.name,
      builder: (controller) => StreamBuilder<List<Category>>(
        stream: repository.watchAllCategories(todoList.id),
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState != ConnectionState.active)
            return const CircularProgressIndicator();
          final categories = snapshot.data ?? [];
          return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Categories', textAlign: TextAlign.center),
                const SizedBox(
                  height: 4.0,
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final category = categories[index];
                      return ListTile(
                        onTap: () {
                          controller.setCurrentCategory(category);
                        },
                        title: Text(category.name),
                      );
                    },
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    addCategory(repository, controller, todoList.id);
                  },
                ),
              ]);
        },
      ),
    );
  }
}
