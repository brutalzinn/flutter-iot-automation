import 'package:application/app/data/model/quarto_model.dart';
import 'package:application/app/data/repository/bedroom_repository.dart';
import 'package:application/app/ui/android/home/home_edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  
  final BedRoomRepository repository;

  HomeController(this.repository);

  //variavel do titulo
  String titulo = '';

  //variavel que controla o loading
  RxBool loading = false.obs;

  //variaveis da lista de notas
  final noteList = <Bedroom>[].obs;

  //variaveis do form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  //recuperar notas para apresentar na tela inicial
  @override
  void onReady() async {
    super.onReady();
    getAll();
  }

  //recuperar todas as notas
  getAll() {
    loading(true);
    repository.getAll().then((data) {
      noteList.value = data;
      loading(false);
    });
  }

  //tratar formulario para inclusao de uma nota
  addNote() {
    formKey.currentState?.reset();
    nomeController.text = '';
    descricaoController.text = '';
    titulo = 'Incluir Nota';
    Get.to(() => HomeEditPage());
  }

  //tratar formulario para edicao de uma nota passando id via arguments
  editNote(Bedroom note) {
    nomeController.text = note.nome;
    descricaoController.text = note.descricao;
    titulo = 'Editar Nota';
    Get.to(() => HomeEditPage(), arguments: note.id);
  }

  //verificar se o formulario esta validado sem erros
  //e se um id de nota eh enviado para a tela de edicao
  //a nota sera atualizada, caso contrario sera criada uma nova nota
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

  //salvar uma nova nota
  saveNote() async {
    final note = Bedroom(
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
    );
    repository.save(note).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  //atualizar uma nota existente cujo id eh recuperado via arguments
  updateNote() async {
    final note = Bedroom(
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

  // atualizar lista de notas apos uma inclusao, alteracao ou exclusao
  refreshNoteList() {
    // recuperar lista de notas
    getAll();
    //fechar dialog
    Get.back();
    //voltar para a lista de notas
    Get.back();
  }

  // validar campo titulo
  validarTitulo(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  //validar campo conteudo
  // validarConteudo(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Preencha o campo Conteúdo.';
  //   }
  //   return null;
  // }
}