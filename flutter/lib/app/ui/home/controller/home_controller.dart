
import 'package:application/app/core/infra/repository/ambiente_repository.dart';
import 'package:application/app/model/database/ambiente_model.dart';
import 'package:application/app/ui/home/home_edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  
  final AmbienteRepository repository;

  HomeController(this.repository);

  //variavel do titulo
  String titulo = '';

  int selectedIndex = 0;
  //variavel que controla o loading
  RxBool loading = false.obs;

  //variaveis da lista de notas
  final noteList = <Ambiente>[].obs;

  //variaveis do form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  @override
  void onReady() async {
    super.onReady();
    getAll();
  }

  getAll() {
    loading(true);
    repository.getAll().then((data) {
      noteList.value = data;
      loading(false);
    });
  }

  addNote() {
    formKey.currentState?.reset();
    nomeController.text = '';
    descricaoController.text = '';
    titulo = 'Adicionar Ambiente';
    Get.to(() => HomeEditPage());
  }


  editNote(Ambiente note) {
    nomeController.text = note.nome;
    descricaoController.text = note.descricao;
    titulo = 'Editar Ambiente';
    Get.to(() => HomeEditPage(), arguments: note.id);
  }

  editMode() {
    contentFocusNode.unfocus();
    if (formKey.currentState!.validate()) {
      loading(true);
      if (Get.arguments == null) {
        saveNote();
      } else {
        updateNote();
      }
    }
  }

  saveNote() async {
    final note = Ambiente(
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
    );
    repository.save(note).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  updateNote() async {
    final note = Ambiente(
      id: Get.arguments,
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
    );
    repository.update(note).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  //excluir nota via id
  deleteNote(int noteId) async {
    loading(true);
    repository.delete(noteId).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  refreshNoteList() {
    getAll();
    Get.back();
    Get.back();
  }

  validarTitulo(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }
}