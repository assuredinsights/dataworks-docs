/*
 *  Copyright 2024 Collate.
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  http://www.apache.org/licenses/LICENSE-2.0
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import { ReactComponent as IconWhatsNew } from '../assets/svg/whats-new.svg';

export enum HELP_ITEMS_ENUM {
  TOUR = 'tour',
  DOC = 'doc',
  API = 'api',
  SLACK = 'slack',
  WHATS_NEW = 'whats-new',
  VERSION = 'version',
}

export interface SupportItem {
  key: HELP_ITEMS_ENUM;
  label: string;
  icon: SvgComponent;
  link?: string;
  isExternal: boolean;
}

export const HELP_ITEMS = [
  // {
  //   key: HELP_ITEMS_ENUM.TOUR,
  //   label: i18n.t('label.tour'),
  //   icon: IconTour,
  //   link: ROUTES.TOUR,
  //   isExternal: false,
  // },
  // {
  //   key: HELP_ITEMS_ENUM.DOC,
  //   label: i18n.t('label.doc-plural'),
  //   icon: IconDoc,
  //   link: URL_OPEN_METADATA_DOCS,
  //   isExternal: true,
  // },
  // {
  //   key: HELP_ITEMS_ENUM.API,
  //   label: i18n.t('label.api-uppercase'),
  //   icon: IconAPI,
  //   link: ROUTES.SWAGGER,
  //   isExternal: false,
  // },
  // {
  //   key: HELP_ITEMS_ENUM.SLACK,
  //   label: i18n.t('label.slack-support'),
  //   icon: IconSlackGrey,
  //   link: URL_JOIN_SLACK,
  //   isExternal: true,
  // },
  // {
  //   key: HELP_ITEMS_ENUM.WHATS_NEW,
  //   label: i18n.t('label.whats-new'),
  //   icon: IconWhatsNew,
  //   isExternal: false,
  // },
  // {
  //   key: HELP_ITEMS_ENUM.VERSION,
  //   label: i18n.t('label.version'),
  //   icon: IconVersionBlack,
  //   link: URL_GITHUB_REPO,
  //   isExternal: true,
  // },
  {
    key: HELP_ITEMS_ENUM.WHATS_NEW,
    label: 'Assured Website',
    icon: IconWhatsNew,
    isExternal: true,
  },
];
