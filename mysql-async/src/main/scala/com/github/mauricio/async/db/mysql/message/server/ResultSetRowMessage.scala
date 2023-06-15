/*
 * Copyright 2013 Maurício Linhares
 *
 * Maurício Linhares licenses this file to you under the Apache License,
 * version 2.0 (the "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations
 * under the License.
 */

package com.github.mauricio.async.db.mysql.message.server

import scala.collection.mutable
import scala.collection.mutable.ArrayBuffer
import io.netty.buffer.ByteBuf

class ResultSetRowMessage
  extends ServerMessage( ServerMessage.Row )
  with mutable.Buffer[ByteBuf]
{

  private val buffer = new ArrayBuffer[ByteBuf]()

  def length: Int = buffer.length

  def apply(idx: Int): ByteBuf = buffer(idx)

  def update(n: Int, newelem: ByteBuf) {
    buffer.update(n, newelem)
  }

  def addOne(elem: ByteBuf): this.type = {
    this.buffer += elem
    this
  }

  def clear() {
    this.buffer.clear()
  }

  def prepend(elem: ByteBuf): this.type = {
    this.buffer.+=:(elem)
    this
  }

  override def insert(n: Int, elem: ByteBuf): Unit = {
    this.buffer.insert(n, elem)
  }

  override def insertAll(n: Int, elems: IterableOnce[ByteBuf]): Unit = {
    this.buffer.insertAll(n, elems)
  }

  def remove(n: Int): ByteBuf = {
    this.buffer.remove(n)
  }

  // Note: This is unused, but added for interface compliance.
  def remove(idx: Int, count: Int): Unit = {
    this.buffer.remove(idx, count)
  }

  def iterator: Iterator[ByteBuf] = this.buffer.iterator

  def patchInPlace(from: Int, patch: IterableOnce[ByteBuf], replaced: Int): ResultSetRowMessage.this.type = {
    this.buffer.patchInPlace(from, patch, replaced)
    this
  }
}